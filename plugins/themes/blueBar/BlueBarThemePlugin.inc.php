<?php

/**
 * @file BlueBarThemePlugin.inc.php
 *
 * Copyright (c) 2003-2008 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class BlueBarThemePlugin
 * @ingroup plugins_themes_blueBar
 *
 * @brief "BlueBar" theme plugin
 */

import('classes.plugins.ThemePlugin');

class BlueBarThemePlugin extends ThemePlugin {
	/**
	 * Get the name of this plugin. The name must be unique within
	 * its category.
	 * @return String name of plugin
	 */
	function getName() {
		return 'BlueBarThemePlugin';
	}

	function getDisplayName() {
		return 'BlueBar Theme';
	}

	function getDescription() {
		return 'Stylesheet with blue header bar and embossed text';
	}

	function getStylesheetFilename() {
		return 'blueBar.css';
	}

	function getLocaleFilename($locale) {
		return null; // No locale data
	}
}

?>
