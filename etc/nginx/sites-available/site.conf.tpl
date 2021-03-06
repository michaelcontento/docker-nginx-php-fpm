server {
    listen 80 default_server;

    root {{DOCUMENT_ROOT}};
    index index.php index.html index.htm;

    location / {
        include /etc/nginx/location.d/*.conf;
        try_files $uri $uri/ /index.php$is_args$args;
    }

    location ~ \.php$ {
        include /etc/nginx/location.d/*.conf;
        fastcgi_pass [::]:9000;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;

        # Prevent exposing nginx + version to $_SERVER
        fastcgi_param SERVER_SOFTWARE "";
    }

    include /etc/nginx/server.d/*.conf;
}
