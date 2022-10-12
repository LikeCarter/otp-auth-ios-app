import Foundation

enum Texts {
    
    enum Shared {
        
        static var added: String { NSLocalizedString("shared added", comment: "") }
        static var cancel: String { NSLocalizedString("shared cancel", comment: "") }
        static var copied: String { NSLocalizedString("shared copied", comment: "") }
        static var delete: String { NSLocalizedString("shared delete", comment: "") }
        static var deleted: String { NSLocalizedString("shared deleted", comment: "") }
        static var error: String { NSLocalizedString("shared error", comment: "") }
        static var OK: String { NSLocalizedString("shared ok", comment: "") }
        static var unknown: String { NSLocalizedString("shared unknown", comment: "") }
        static var try_again: String { NSLocalizedString("shared try again", comment: "") }
    }
    
    enum Auth {
        
        static var logic_description: String { NSLocalizedString("auth login description", comment: "") }
        static var change_description: String { NSLocalizedString("auth change description", comment: "") }
        
        enum Alert {
            
            static var title: String { NSLocalizedString("auth alert fail title", comment: "") }
            static var description: String { NSLocalizedString("auth alert fail description", comment: "") }
        }
        
    }
    
    enum Alerts {
        
        static var code_added: String { NSLocalizedString("alert service code added", comment: "") }
        static var code_deleted: String { NSLocalizedString("alert service code deleted", comment: "") }
        static var no_token: String { NSLocalizedString("alert service no token", comment: "") }
        static var token_exists: String { NSLocalizedString("alert service token exists", comment: "") }
        static var incorrect_url: String { NSLocalizedString("alert service incorrect url", comment: "") }
        static var email_error: String { NSLocalizedString("alert service email error", comment: "") }
    }
    
    enum Permissions {
        
        static var denied_title: String { NSLocalizedString("permissions camera denied alert title", comment: "") }
        static var denied_subtitle: String { NSLocalizedString("permissions camera denied alert subtitle", comment: "") }
        static var denied_action: String { NSLocalizedString("permissions camera denied alert action", comment: "") }
    }
    
    enum RootController {

        static var title: String { NSLocalizedString("root controller title", comment: "") }
        
        static var header_view_action: String { NSLocalizedString("root controller header view action", comment: "") }
        static var header_view_description: String { NSLocalizedString("root controller header view description", comment: "") }
        
        static var account_section_header: String { NSLocalizedString("root controller section account header", comment: "") }
        static var empty_cell_title: String { NSLocalizedString("root controller empty cell title", comment: "") }
        static var empty_cell_subitle: String { NSLocalizedString("root controller empty cell subtitle", comment: "") }
        static var account_section_footer: String { NSLocalizedString("root controller account section footer", comment: "") }
        
        static var settings_button: String { NSLocalizedString("root controller settings button", comment: "") }
        static var settings_section_footer: String { NSLocalizedString("root controller settings section footer", comment: "") }
        
        static var delete_alert_title: String { NSLocalizedString("settings controller delete alert title", comment: "") }
        static var delete_alert_message: String { NSLocalizedString("settings controller delete alert message", comment: "") }
    }
    
    enum SettingsController {
        
        static var title: String { NSLocalizedString("settings controller title", comment: "") }
        
        static var app_section_header: String { NSLocalizedString("setings controller app section header", comment: "") }
        static var appereance_button: String { NSLocalizedString("settings controller appereance cell", comment: "") }
        static var notification_button: String { NSLocalizedString("settings controller notification cell", comment: "") }
        static var sounds_button: String { NSLocalizedString("settings controller sounds cell", comment: "") }
        static var password_button: String { NSLocalizedString("settings controller password cell", comment: "") }
        static var language_button: String { NSLocalizedString("settings controller language cell", comment: "") }
        static var app_section_footer: String { NSLocalizedString("setings controller app section footer", comment: "") }
        
        static var feedback_section_header: String { NSLocalizedString("setings controller feedback section header", comment: "") }
        static var review_button: String { NSLocalizedString("settings controller review cell", comment: "") }
        static var contact_button: String { NSLocalizedString("settings controller contact cell", comment: "") }
        static var feedback_email_body: String { NSLocalizedString("settings controller feedback email body", comment: "") }
        static var feedback_section_footer: String { NSLocalizedString("setings controller feedback section footer", comment: "") }
        
        static var media_section_header: String { NSLocalizedString("setings controller media section header", comment: "") }
        static var website_button: String { NSLocalizedString("settings controller website cell", comment: "") }
        static var telegram_button: String { NSLocalizedString("settings controller telegram cell", comment: "") }
        static var twitter_button: String { NSLocalizedString("settings controller twitter cell", comment: "") }
        static var instagram_button: String { NSLocalizedString("settings controller instagram cell", comment: "") }
        static var media_section_footer: String { NSLocalizedString("setings controller media section footer", comment: "") }
        
        static var about_button: String { NSLocalizedString("settings controller about cell", comment: "") }
        static var about_section_footer: String { NSLocalizedString("setings controller about section footer", comment: "") }
        
        enum Password {
            
            static var title: String { NSLocalizedString("settings password controller title", comment: "") }
            
            static var header: String { NSLocalizedString("setings password controller section header", comment: "") }
            static var cell: String { NSLocalizedString("settings password controller cell", comment: "") }
            static var footer: String { NSLocalizedString("setings password controller section footer", comment: "") }
        }
        
        enum Appearance {
            
            static var title: String { NSLocalizedString("settings appearance controller title", comment: "") }
            
            static var appearance_header: String { NSLocalizedString("settings appearance controller table header", comment: "") }
            static var automatic_footer: String { NSLocalizedString("settings appearance controller table automatic footer", comment: "") }
            static var manually_footer: String { NSLocalizedString("settings appearance controller table manually footer", comment: "") }
            
            static var automatic_cell: String { NSLocalizedString("settings appearance controller automatic cell", comment: "") }
            static var light_cell: String { NSLocalizedString("settings appearance controller light cell", comment: "") }
            static var dark_cell: String { NSLocalizedString("settings appearance controller dark cell", comment: "") }
            
            static var colors_header: String { NSLocalizedString("settings appearance controller colors table header", comment: "") }
            static var colors_footer: String { NSLocalizedString("settings appearance controller colors table footer", comment: "") }
            
            static var red_color: String { NSLocalizedString("settings appearance controller red color cell", comment: "") }
            static var pink_color: String { NSLocalizedString("settings appearance controller pink color cell", comment: "") }
            static var orange_color: String { NSLocalizedString("settings appearance controller orange color cell", comment: "") }
            static var yellow_color: String { NSLocalizedString("settings appearance controller yellow color cell", comment: "") }
            static var green_color: String { NSLocalizedString("settings appearance controller green color cell", comment: "") }
            static var blue_color: String { NSLocalizedString("settings appearance controller blue color cell", comment: "") }
            static var purple_color: String { NSLocalizedString("settings appearance controller purple color cell", comment: "") }
            static var gray_color: String { NSLocalizedString("settings appearance controller gray color cell", comment: "") }
        }
        
        enum Sounds {
            
            static var title: String { NSLocalizedString("settings sounds controller title", comment: "") }
            
            static var header: String { NSLocalizedString("settings sounds controller table header", comment: "") }
            static var footer: String { NSLocalizedString("settings sounds controller table footer", comment: "") }
            
            static var enabled: String { NSLocalizedString("settings sounds controller enabled cell", comment: "") }
            static var disabled: String { NSLocalizedString("settings sounds controller disabled cell", comment: "") }
            static var during_day: String { NSLocalizedString("settings sounds controller during day cell", comment: "") }
        }
        
        enum Languages {
            
            static var title: String { NSLocalizedString("settings languages controller title", comment: "") }
            
            static var header: String { NSLocalizedString("settings languages controller header", comment: "") }
            static var footer: String { NSLocalizedString("settings languages controller footer", comment: "") }
            
            static var russian: String { NSLocalizedString("settings languages controller cell russian", comment: "") }
            static var english: String { NSLocalizedString("settings languages controller cell english", comment: "") }
            static var german: String { NSLocalizedString("settings languages controller cell german", comment: "") }
        }
        
        enum AboutApp {
            
            static var title: String { NSLocalizedString("settings about app controller title", comment: "") }
            
            static var version_header: String { NSLocalizedString("settings about app controller version header", comment: "") }
            static var version_cell_title: String { NSLocalizedString("settings about app controller version cell title", comment: "") }
            static var version_cell_detail: String { Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? Texts.Shared.unknown }
            static var version_footer: String { NSLocalizedString("settings about app controller version footer", comment: "") }
            
            static var package_header: String { NSLocalizedString("settings about app controller package header", comment: "") }
            static var package_cell: String { NSLocalizedString("settings about app controller package cell", comment: "") }
            static var package_footer: String { NSLocalizedString("settings about app controller package footer", comment: "") }
        }
        
    }
}
