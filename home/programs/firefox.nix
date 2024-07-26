{ pkgs, ... }:
{

  programs.firefox = {
    enable = true;
    package = pkgs.firefox_nightly;
    policies = {
      DisplayBookmarksToolbar = true;
      DontCheckDefaultBrowser = true;
      DisablePocket = true;
      DisableAppUpdate = true;
      Preferences = {
        "browser.toolbars.bookmarks.visibility" = "always";
        "media.ffmpeg.vaapi.enabled" = true;
      };
      profiles.default = {
        settings = {
          "signon.rememberSignons" = false;
          "browser.shell.checkDefaultBrowser" = false;
          "security.family_safety.mode" = 0;
          "geo.provider.network.url" = "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
          "geo.provider.use_gpsd" = false;
          # Reduce File IO / SSD abuse
          # Otherwise, Firefox bombards the HD with writes. Not so nice for SSDs.
          # This forces it to write every 30 minutes, rather than 15 seconds.
          "browser.sessionstore.interval" = "1800000";
          # Disable battery API
          # https://developer.mozilla.org/en-US/docs/Web/API/BatteryManager
          # https://bugzilla.mozilla.org/show_bug.cgi?id=1313580
          "dom.battery.enabled" = false;
          # Disable "beacon" asynchronous HTTP transfers (used for analytics)
          # https://developer.mozilla.org/en-US/docs/Web/API/navigator.sendBeacon
          "beacon.enabled" = false;
          # Disable pinging URIs specified in HTML <a> ping= attributes
          # http://kb.mozillazine.org/Browser.send_pings
          "browser.send_pings" = false;

          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.server" = "data:,";
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.coverage.opt-out" = true;
          "toolkit.coverage.opt-out" = true;
          "toolkit.coverage.endpoint.base" = "";
          "experiments.supported" = false;
          "experiments.enabled" = false;
          "experiments.manifest.uri" = "";
          "browser.ping-centre.telemetry" = false;
          # https://mozilla.github.io/normandy/
          "app.normandy.enabled" = false;
          "app.normandy.api_url" = "";
          "app.shield.optoutstudies.enabled" = false;
          # Disable health reports (basically more telemetry)
          # https://support.mozilla.org/en-US/kb/firefox-health-report-understand-your-browser-perf
          # https://gecko.readthedocs.org/en/latest/toolkit/components/telemetry/telemetry/preferences.html
          "datareporting.healthreport.uploadEnabled" = false;
          "datareporting.healthreport.service.enabled" = false;
          "datareporting.policy.dataSubmissionEnabled" = false;

          # Disable crash reports
          "breakpad.reportURL" = "";
          "browser.tabs.crashReporting.sendReport" = false;
          "browser.crashReports.unsubmittedCheck.autoSubmit2" = false; # don't submit backlogged reports

          # Disable Form autofill
          # https://wiki.mozilla.org/Firefox/Features/Form_Autofill
          "browser.formfill.enable" = false;
          "extensions.formautofill.addresses.enabled" = false;
          "extensions.formautofill.available" = "off";
          "extensions.formautofill.creditCards.available" = false;
          "extensions.formautofill.creditCards.enabled" = false;
          "extensions.formautofill.heuristics.enabled" = false;
        };
      };
    };
  };
}
