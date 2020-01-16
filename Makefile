container_engine=podman
project_dir=$(shell pwd)

# Build your site
build:
	$(call run_jekyll_command, jekyll build)

# Serve your site locally
serve:
	$(call run_jekyll_command, jekyll serve --watch)

# Clean the site (removes site output and metadata file) without building.
clean:
	$(call run_jekyll_command, jekyll clean)

bundle_install:
	$(call run_jekyll_command, bundle install)

gem_install_bundler:
	$(call run_jekyll_command, gem install bundler)

# Run jekyll command in container
define run_jekyll_command
	$(container_engine) run --rm -it \
		--volume="$(project_dir):/srv/jekyll" \
		--volume="$(project_dir)/vendor/bundle:/usr/local/bundle" \
		--publish 4000:4000 \
		jekyll/jekyll:latest \
		$(1)
endef
