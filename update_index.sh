echo "patch new version"
yq eval '.version |= split(".") | .[2] = (."[2"] + 1) | join(".")'  configMapSecrets/Chart.yaml -i

yq '.version' configMapSecrets/Chart.yaml

echo "package new version"
helm package configMapSecrets/.

echo "reindex to repository with the new path version"
helm repo index --url https://tal-hason.github.io/helm-cm-n-secrets/ .

echo "Add to git"
git add -A

echo "Commit new version"
git commit -m "new patch commited"

echo "push new version to remote"
git push