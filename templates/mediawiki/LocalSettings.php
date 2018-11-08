<?php
# This file was automatically generated by the MediaWiki 1.31.1
# installer. If you make manual changes, please keep track in case you
# need to recreate them later.
#
# See includes/DefaultSettings.php for all configurable settings
# and their default values, but don't forget to make changes in _this_
# file, not there.
#
# Further documentation for configuration settings may be found at:
# https://www.mediawiki.org/wiki/Manual:Configuration_settings

# Protect against web entry
if ( !defined( 'MEDIAWIKI' ) ) {
	exit;
}


## Uncomment this to disable output compression
# $wgDisableOutputCompression = true;

$wgSitename = "Bitraf";
$wgMetaNamespace = "Bitraf";

## The URL base path to the directory containing the wiki;
## defaults for all runtime URL paths are based off of this.
## For more information on customizing the URLs
## (like /w/index.php/Page_title to /wiki/Page_title) please see:
## https://www.mediawiki.org/wiki/Manual:Short_URL
$wgScriptPath = "/w";

## The protocol and server name to use in fully-qualified URLs
# This is the ideal pattern, but some tuning from Nginx is required.
# $wgServer = "https://${_SERVER['HTTP_HOST']}";
$wgServer = "https://bitraf.no";

## The URL path to static resources (images, scripts, etc.)
$wgResourceBasePath = $wgScriptPath;

## The URL path to the logo.  Make sure you change this from the default,
## or else you'll overwrite your logo when you upgrade!
$wgLogo = "$wgResourceBasePath/resources/assets/wiki.png";

## UPO means: this is also a user preference option

$wgEnableEmail = true;
$wgEnableUserEmail = false; # UPO

$wgEmergencyContact = "post@bitraf.no";
$wgPasswordSender = "post@bitraf.no";

$wgEnotifUserTalk = true; # UPO
$wgEnotifWatchlist = true; # UPO
$wgEmailAuthentication = true;

## Database settings
$wgDBtype = "postgres";
$wgDBserver = "{{ mediawiki__wgDBserver }}";
$wgDBname = "{{ mediawiki__wgDBname }}";
$wgDBuser = "{{ mediawiki__wgDBuser }}";
$wgDBpassword = "{{ mediawiki__wgDBpassword }}";

# Postgres specific settings
$wgDBport = "5432";
$wgDBmwschema = "public";

## Shared memory settings
$wgMainCacheType = CACHE_ACCEL;
$wgMemCachedServers = [];

## To enable image uploads, make sure the 'images' directory
## is writable, then set this to true:
$wgEnableUploads = true;
$wgUseImageMagick = true;
$wgImageMagickConvertCommand = "/usr/bin/convert";
$wgFileExtensions[] = 'docx';
$wgFileExtensions[] = 'xls';
$wgFileExtensions[] = 'pdf';
$wgFileExtensions[] = 'odt';
$wgFileExtensions[] = 'ods';
$wgFileExtensions[] = 'gz';

# InstantCommons allows wiki to use images from https://commons.wikimedia.org
$wgUseInstantCommons = false;

# Periodically send a pingback to https://www.mediawiki.org/ with basic data
# about this MediaWiki instance. The Wikimedia Foundation shares this data
# with MediaWiki developers to help guide future development efforts.
$wgPingback = true;

## If you use ImageMagick (or any other shell command) on a
## Linux server, this will need to be set to the name of an
## available UTF-8 locale
$wgShellLocale = "C.UTF-8";

## Set $wgCacheDirectory to a writable directory on the web server
## to make your wiki go slightly faster. The directory should not
## be publically accessible from the web.
$wgCacheDirectory = "$IP/cache";

# Site language code, should be one of the list in ./languages/data/Names.php
$wgLanguageCode = "nb";

$wgSecretKey = "{{ mediawiki__wgSecretKey }}";

# Changing this will log out all existing sessions.
$wgAuthenticationTokenVersion = "1";

# Site upgrade key. Must be set to a string (default provided) to turn on the
# web installer while LocalSettings.php is in place
$wgUpgradeKey = "{{ mediawiki__wgUpgradeKey }}";

## For attaching licensing metadata to pages, and displaying an
## appropriate copyright notice / icon. GNU Free Documentation
## License and Creative Commons licenses are supported so far.
$wgRightsPage = ""; # Set to the title of a wiki page that describes your license/copyright
$wgRightsUrl = "";
$wgRightsText = "";
$wgRightsIcon = "";

# TODO: use Bitraf's favicon.
$wgFavicon = "https://www.mediawiki.org/static/images/project-logos/mediawikiwiki.png";

# Path to the GNU diff3 utility. Used for conflict resolution.
$wgDiff3 = "/usr/bin/diff3";

## Default skin: you can change the default skin. Use the internal symbolic
## names, ie 'vector', 'monobook':
$wgDefaultSkin = "bitraf";

# Enabled skins.
# The following skins were automatically enabled:
wfLoadSkin( 'Bitraf' );
#wfLoadSkin( 'CologneBlue' );
#wfLoadSkin( 'Modern' );
wfLoadSkin( 'MonoBook' );
wfLoadSkin( 'Timeless' );
wfLoadSkin( 'Vector' );

wfLoadExtension( 'Cite' );
wfLoadExtension( 'ParserFunctions' );

# End of automatically generated settings.
# Add more configuration options below.

require_once "$IP/extensions/p2k12-auth.php";
$wgAuth = new p2k12Auth();

$wgGroupPermissions['*']['createaccount'] = false;
$wgGroupPermissions['*']['edit'] = false;

$wgShowSQLErrors = true;

$wgArticlePath = '/wiki/$1';


#
# WikiEditor
#
wfLoadExtension('WikiEditor');
# Enables use of WikiEditor by default but still allows users to disable
# it in preferences
$wgDefaultUserOptions['usebetatoolbar'] = 1;

# Enables link and table wizards by default but still allows users to
# disable them in preferences
$wgDefaultUserOptions['usebetatoolbar-cgd'] = 1;

# Displays the Preview and Changes tabs
$wgDefaultUserOptions['wikieditor-preview'] = 1;

# Displays the Publish and Cancel buttons on the top right side
$wgDefaultUserOptions['wikieditor-publish'] = 1;

# CharInsert
wfLoadExtension('CharInsert');

# Spam-hjelp
wfLoadExtension('Nuke');
wfLoadExtension('Renameuser');

#http://www.mediawiki.org/wiki/Extension:Cite/Cite.php
# Add <references/> and <ref>
wfLoadExtension( 'Cite' );

# enable selected user groups to edit the interwiki table
# https://www.mediawiki.org/wiki/Extension:Interwiki
wfLoadExtension( 'Interwiki' );
# sysops and bureaucrats can edit the interwiki table
$wgGroupPermissions['sysop']['interwiki'] = true;
$wgGroupPermissions['bureaucrat']['interwiki'] = true;

#2017-09-11: lagt til av Torfinn I.
#https://www.mediawiki.org/wiki/Extension:ParserFunctions
# add #if and other parser functions
wfLoadExtension( 'ParserFunctions' );
$wgPFEnableStringFunctions = true;
# added 2018-02-01 by tingo (Torfinn Ingolfsen)
require_once "$IP/extensions/googleAnalytics/googleAnalytics.php";
// Add HTML code for any additional web analytics (can be used alone or with $wgGoogleAnalyticsAccount)
$wgGoogleAnalyticsOtherCode = '<script type="text/javascript" src="https://analytics.example.com/tracking.js"></script>';

// Optional configuration (for defaults see googleAnalytics.php)
// Store full IP address in Google Universal Analytics (see https://support.google.com/analytics/answer/2763052?hl=en for details)
$wgGoogleAnalyticsAnonymizeIP = false; 
// Array with NUMERIC namespace IDs where web analytics code should NOT be included.
$wgGoogleAnalyticsIgnoreNsIDs = array(500);
// Array with page names (see magic word Extension:Google Analytics Integration) where web analytics code should NOT be included.
$wgGoogleAnalyticsIgnorePages = array('ArticleX', 'Foo:Bar');
// Array with special pages where web analytics code should NOT be included.
$wgGoogleAnalyticsIgnoreSpecials = array( 'Userlogin', 'Userlogout', 'Preferences', 'ChangePassword', 'OATH');
// Use 'noanalytics' permission to exclude specific user groups from web analytics, e.g.
$wgGroupPermissions['sysop']['noanalytics'] = true;
$wgGroupPermissions['bot']['noanalytics'] = true;
// To exclude all logged in users give 'noanalytics' permission to 'user' group, i.e.
//$wgGroupPermissions['user']['noanalytics'] = true;

##GOOGLE TAG MANAGER - BL's konto
require_once "$IP/extensions/GoogleTagManager/GoogleTagManager.php";

// --- Semantic mediawiki
$smwgShowFactbox = SMW_FACTBOX_NONEMPTY;
enableSemantics("bitraf.no");

// --- Scribunto
wfLoadExtension("Scribunto");
#$wgScribuntoDefaultEngine = "luastandalone";

# $wgShowExceptionDetails = true;
# $wgShowDBErrorBacktrace = true;

wfLoadExtension("SemanticScribunto");

// --- CodeEditor
wfLoadExtension( 'CodeEditor' );
$wgDefaultUserOptions['usebetatoolbar'] = 1; // user option provided by WikiEditor extension
$wgScribuntoUseCodeEditor = true;
$wgDebugLogFile = "/var/log/nginx/mediawiki.log";

$wgShowExceptionDetails = true;
$wgShowDBErrorBacktrace = true;
