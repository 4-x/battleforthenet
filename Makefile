PUBLISH_BRANCH:=gh-pages

setup:
	npm install

prep_branch:
	git branch -D ${PUBLISH_BRANCH} | true
	git checkout -b ${PUBLISH_BRANCH}

build:
	NODE_ENV=production npm run build

cache_bust:
	CACHE_BUST=`git rev-parse HEAD` && sed -i "s/CACHE_BUST/$$CACHE_BUST/g" index.html

publish_branch:
	git config user.email "fftf@users.noreply.github.com"
	git config user.name "CircleCI Script"
	git commit -a -m "Build static assets"
	git push --quiet ${CIRCLE_REPOSITORY_URL} +${PUBLISH_BRANCH};

run:
	./node_modules/.bin/gulp watch 