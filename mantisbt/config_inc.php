<?php
# --- Database Configuration ---
$g_hostname             = 'mantisbtdb';
$g_db_type              = 'mysqli';
$g_database_name        = 'bugtracker';
$g_db_username          = 'mantisbtQNlVXns';
$g_db_password          = 'mantisbtQNlVXns';

# --- Security ---
$g_crypto_master_salt   = 'AaOx3qkMnN/g7RYHle4kRSXbJdHZU9SrQM/r8pM/Ve8=';

# --- Email Configuration ---
$g_phpMailer_method     = PHPMAILER_METHOD_SMTP;
$g_smtp_host            = 'smtp.qq.com';
$g_smtp_port            = '465';
$g_smtp_connection_mode = 'ssl';
$g_smtp_username        = '';
$g_smtp_password        = '';
$g_webmaster_email      = '';
$g_from_email           = '';
$g_return_path_email    = '';
$g_from_name            = '';

# --- Branding ---
#$g_window_title         = '';

# --- Real names ---
$g_show_realname        = ON;

# --- TimeZone and lang ---
$g_default_timezone     = 'Asia/Shanghai';
$g_default_language     = 'chinese_simplified';

# --- upload ---
$g_allow_file_upload    = OFF;

# --- fields to show when report bugs ---
$g_bug_report_page_fields = array("category_id", "severity", "product_version", "handler");
