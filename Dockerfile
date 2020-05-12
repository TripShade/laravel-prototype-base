FROM composer:latest as build
WORKDIR /app
RUN composer create-project --prefer-dist laravel/laravel ./

# Install packages
RUN composer require orchid/platform
RUN composer require --dev laravel-shift/blueprint
RUN composer install

# Choose bring in existing folders, drafts
COPY ./composer.json /app/composer.json
COPY ./.env /app/.env
COPY ./draft.yml /app/draft.yml

RUN composer update

# Active/Run installed packages and stub
RUN cd /app && yes | php artisan orchid:install
RUN cd /app && php artisan blueprint:build
# RUN php artisan blueprint:build module-A-draft.yml

# COPY ./app/Orchid ./app/Orchid
# COPY ./routes /app/routes

FROM php:7.3
RUN docker-php-ext-install pdo mbstring pdo_mysql
RUN apt-get update && apt-get install nano
EXPOSE 8080
COPY --from=build /app /app

CMD php /app/artisan serve --host=0.0.0.0 --port=8080