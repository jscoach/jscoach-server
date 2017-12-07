class Package < ActiveRecord::Base
  module GithubRelated
    extend ActiveSupport::Concern

    # Update the attributes of a package using a given object from GitHub
    def assign_github_attributes(github)
      self.assign_attributes({
        repo: github.full_name,
        stars: github.stargazers_count,
        is_fork: github.fork || github.fetch_is_copy,
        readme: github.try(:fetch_readme, path: self.custom_repo_path),
        languages: github.fetch_languages,
        github_homepage: github.homepage
      }.compact)
    end
  end
end
