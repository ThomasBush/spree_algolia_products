Deface::Override.new(virtual_path: 'spree/admin/shared/sub_menu/_configuration',
                     name: 'add_algolia_settings_to_admin_menu',
                     insert_bottom: '[data-hook="admin_configurations_sidebar_menu"]',
                     text: '<%= configurations_sidebar_menu_item Spree.t(:algolia_settings_admin), spree.admin_algolia_settings_url %>')
