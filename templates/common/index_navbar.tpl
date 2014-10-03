{**
 * templates/common/navbar.tpl
 *
 * Copyright (c) 2013-2014 Simon Fraser University Library
 * Copyright (c) 2003-2014 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Navigation Bar
 *
 *}
	{if $isUserLoggedIn}
		<ul class="navbar" id="nav-login">
	{else}
		<ul class='navbar' id='nav-nologin'>
	{/if}
		<li id="home"><a href="{url page="index"}">{translate key="navigation.home"}</a></li>
		<!-- <li id="about"><a href="{url page="about"}">{translate key="navigation.about"}</a></li> -->
		
		{if $siteCategoriesEnabled}
			<li id="categories"><a href="{url journal="index" page="search" op="categories"}">{translate key="navigation.categories"}</a></li>
		{/if}

		{if !$currentJournal || $currentJournal->getSetting('publishingMode') != $smarty.const.PUBLISHING_MODE_NONE}
			<li id="search"><a href="{url page="search"}">{translate key="navigation.search"}</a></li>
		{/if}
		
		<!-- User Links -->		
		{if $isUserLoggedIn}
			<li id="userHome"><a href="{url page="user"}">{translate key="navigation.userHome"}</a></li>
			
			{if $hasOtherJournals}
				<li><a href="{url journal="index" page="user"}">{translate key="plugins.block.user.myJournals"}</a></li>
			{/if}
			<li><a href="{url page="user" op="profile"}">{translate key="plugins.block.user.myProfile"}</a></li>
			<li><a href="{url page="login" op="signOut"}">{translate key="plugins.block.user.logout"}</a></li>
			{if $userSession->getSessionVar('signedInAs')}
				<li><a href="{url page="login" op="signOutAsUser"}">{translate key="plugins.block.user.signOutAsUser"}</a></li>
			{/if}	
			<li id='logged-in'>{translate key="plugins.block.user.loggedInAs"} <strong>{$loggedInUsername|escape}</strong></li>
		{else}
			<li id="login"><a href="{url page="login"}">{translate key="navigation.login"}</a></li>
			{if !$hideRegisterLink}
				<li id="register"><a href="{url page="user" op="register"}">{translate key="navigation.register"}</a></li>
			{/if}
			<li><a class="blockTitle" href="javascript:openHelp('http://jps/index.php/index/help/view/user/topic/000001')">Journal Help</a></li>
			<li><a class="blockTitle" href="http://pkp.sfu.ca/ojs/" id="developedBy">Open Journal Systems</a></li>
		{/if}
		
		<!-- Add javascript required for font sizer -->
			<script type="text/javascript">{literal}
				<!--
				$(function(){
					fontSize("#sizer", "body", 9, 16, 32, "{/literal}{$basePath|escape:"javascript"}{literal}"); // Initialize the font sizer
				});
				// -->
			{/literal}</script>
		<!--
		<li>
			<div class="block" id="sidebarFontSize">
				<div id="sizer"></div>
			</div>
		</li>
		-->
	</ul>

