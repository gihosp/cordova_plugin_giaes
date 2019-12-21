plugman create --name cordova_plugin_giaes --plugin_id cordova_plugin_giaes --plugin_version 0.0.1

plugman platform add --platform_name android

plugman platform add --platform_name ios

For compilation--
plugman createpackagejson "path".
Note:we need to provide name,version and everthing.with gihub url for repo maintain.


For Publish----

npm publish
(OR)

echo "# cordova_plugin_giaes" >> README.md
git init
git add README.md
git commit -m "first commit"
git remote add origin https://github.com/gihosp/cordova_plugin_giaes.git
git push -u origin master

Existing------------------------

git remote add origin https://github.com/gihosp/cordova_plugin_giaes.git
git push -u origin master



For Usage---

declare var window: any;

window.plugins.cordova_plugin_giaes.encrypt(data);


"# cordova_plugin_giaes" 
