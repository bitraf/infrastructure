<?php
if ( !defined( 'MEDIAWIKI' ) ) {
	die( 'This file is a MediaWiki extension, it is not a valid entry point.\n' );
}

$wgExtensionCredits['other'][] = array(
	'path'           => __FILE__,
	'name'           => 'Google Tag Manager Integration',
	'version'        => '0.1',
	'author'         => 'Felix Kaiser',
	'descriptionmsg' => 'googletagmanager-desc',
	'url'            => 'https://www.mediawiki.org/wiki/Extension:Google_Tag_Manager'
);

$wgExtensionMessagesFiles['GoogleTagManager'] = dirname(__FILE__) . '/GoogleTagManager.i18n.php';

$wgHooks['SkinAfterBottomScripts'][]  = 'efGoogleTagManagerHookText';

$wgGoogleTagManagerContainerID = "";

// These options are deprecated.
// You should add the "noanalytics" right to the group
// Ex: $wgGroupPermissions["sysop"]["noanalytics"] = true;
$wgGoogleTagManagerIgnoreSysops = true;
$wgGoogleTagManagerIgnoreBots = true;

function efGoogleTagManagerHookText( $skin, &$text='' ) {
	$text .= efAddGoogleTagManager();
	return true;
}

function efAddGoogleTagManager() {
	global $wgGoogleTagManagerContainerID, $wgGoogleTagManagerIgnoreSysops, $wgGoogleTagManagerIgnoreBots, $wgUser;
	if ( $wgUser->isAllowed( 'noanalytics' ) ||
		 $wgGoogleTagManagerIgnoreBots && $wgUser->isAllowed( 'bot' ) ||
		 $wgGoogleTagManagerIgnoreSysops && $wgUser->isAllowed( 'protect' ) ) {
		return "\n<!-- Google Tag Manager tracking is disabled for this user -->";
	}
	if ( $wgGoogleTagManagerContainerID === '' ) {
		return "\n<!-- Set \$wgGoogleTagManagerContainerID to your cointainer ID provided by Google Tag Manager. -->";
	}
	return <<<HTML
<!-- Google Tag Manager (added by extension GoogleTagManager) -->
<noscript><iframe src="//www.googletagmanager.com/ns.html?id={$wgGoogleTagManagerContainerID}"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'//www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','{$wgGoogleTagManagerContainerID}');</script>
<!-- End Google Tag Manager -->
HTML;
}