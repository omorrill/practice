<?php
/**
 * @file
 * X-ray module settings UI.
 */
 
/**
 * Form Builder; Configure which X-ray information is shown.
 * 
 * This form procides feeds the menu callback for the X-ray settings page.
 * 
 * @ingroup forms
 * @see system_settings_form() 
 */
 function xray_admin_settings() {
   $form = array();
   // X-ray output visibility settings.
   $form['display'] = array(
     '#type' => 'fieldset',
     '#title' => t('Display options'),
   );
   $form['display']['xray_display_sections_summaries'] = array(
     '#type' => 'checkbox',
     '#title' => t('Shows summaries on administration sections.'),
	 '#default_value' => variable_get('xray_display_section_summaries', 1),
	 '#description' => t('If unchecked, the summaries will still be visible on the <a href="@xray-overview">X-ray reports</a> page.',
	   array('@xray-overview' => url('admin/reports/xray'))
	 ),
   );
   $form['display']['xray_display_callback_function'] = array(
     '#type' => 'checkbox',
     '#title' => t('Show the page callback function on all pages.'),
	 '#default_value' => variable_get('xray_display_callback_function', 1),
   );
   $form['display']['xray_display_form_id'] = array(
     '#type' => 'checkbox',
     '#title' => t('Show ID in forms.'),
	 '#default_value' => variable_get('xray_display_fomr_id', 1),
   );
   return system_settings_form($form);
 }