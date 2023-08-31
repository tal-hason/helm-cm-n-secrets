echo "patch new version"
OLD_VERSION=$(yq eval '.version' configMapSecrets/Chart.yaml)
NEW_VERSION=$(echo $OLD_VERSION | awk -F. '{print $1"."$2"."$3+1}')
yq eval '.version = "'$NEW_VERSION'"' configMapSecrets/Chart.yaml -i

sed -i "s/latest_vesion:.*/latest_vesion: "${NEW_VERSION}"/" "README.md"

yq '.version' configMapSecrets/Chart.yaml

echo "package new version"
helm package configMapSecrets/.

echo "reindex to repository with the new path version"
helm repo index --url https://tal-hason.github.io/helm-cm-n-secrets/ .

echo "Add to git"
git add -A

echo "Commit new version ${NEW_VERSION}"
git commit -m "new patch commited"

echo "push new version ${NEW_VERSION} to remote"
git push

echo "version ${NEW_VERSION} is in repository"