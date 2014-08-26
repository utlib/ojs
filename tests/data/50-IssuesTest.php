<?php

/**
 * @file tests/data/50-IssuesTest.php
 *
 * Copyright (c) 2014 Simon Fraser University Library
 * Copyright (c) 2000-2014 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class IssuesTest
 * @ingroup tests_data
 *
 * @brief Data build suite: Create issues
 */

import('lib.pkp.tests.WebTestCase');

class IssuesTest extends WebTestCase {
	/**
	 * Create issues
	 */
	function testCreateIssues() {
		$this->open(self::$baseUrl);

		$this->clickAndWait('link=User Home');
		$this->clickAndWait('link=Editor');
		$this->clickAndWait('link=Create Issue');

		// Create issue
		$this->type('id=volume', '1');
		$this->type('id=number', '1');
		$this->type('id=year', '2014');
		$this->click('id=showVolume');
		$this->click('id=showNumber');
		$this->click('id=showYear');
		$this->clickAndWait('css=input.button.defaultButton');

		// Create issue
		$this->clickAndWait('link=Create Issue');
		$this->type('id=volume', '1');
		$this->type('id=number', '2');
		$this->type('id=year', '2014');
		$this->click('id=showVolume');
		$this->click('id=showNumber');
		$this->click('id=showYear');
		$this->clickAndWait('css=input.button.defaultButton');
	}
}
