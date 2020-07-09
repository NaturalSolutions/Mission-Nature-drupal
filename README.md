# Mission Nature drupal7+vues sql postgres
Drupal 7 avec SGBD postgreSQL

## Mise à jour de drupal en prod
(cf: https://www.drupal.org/docs/7/update/core-option-1)

- Faire une sauvegarde de la base de données et des fichiers

- Renommez le dossier du site en prod
> mv www www_old

- Charger et de-ziper un drupal à jour.
Renommer si nécessaire le dossier en www

- Modifiez les settings.php avec les paramètres de la base de données de prod et mettez le paramètre update.php à TRUE

- Passez les mises à jour.

- Vérifiez les permissions. www_data doit avoir tous les droits sur le dossier files (à moins que vous ayez mis des données privées dedans)

- Lancez le script update.php
> <ipdemonsite>/update.php

- Passez le paramètre update.php à FALSE

- Si les pages ne s'affichent pas vérifier si le .htaccess correspond à la sauvegarde dans le www-old

## Vues SQL
v_file_obs et v_all_obs se trouvent dans le dossier data.
### MISE à jour des vues sql
Vérifiez les privilèges à chaque mise à jour des vues v_file_obs et v_all_obs

## TODO
Permettre les appels HTTPS pour installer librairie drush et faire des git clone
