# frozen_string_literal: true

class CommitsController < ApplicationController
  def index
    @contributor = set_contributor
    @index = search_comments(@contributor)
  end

  private

  def set_contributor
    Contributor.find_by(name: params[:contributor_name])
  end

  def search_comments(contributor)
    Commit.where(contributor_id: contributor.id)
  end
end
