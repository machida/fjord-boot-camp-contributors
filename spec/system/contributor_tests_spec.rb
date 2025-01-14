# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ContributorTests', type: :system do
  describe 'verify ranking', js: true do
    before do
      create(:contributor1)
      create(:contributor2)
      create(:contributor3)
    end

    it 'verify ranking are in ascending order', js: true do
      visit '/contributors/all-time'

      ranking_table = page.find('table').all('tr').map { |row| row.all('th, td').map { |cell| cell.text.strip } }
      ranking_table.shift
      ranking_table = ranking_table.transpose[0]
      ranking_table.map { |value| value.delete!('#') }
      expect(ranking_table[0].to_i).to eq(1)
      expect(ranking_table[1].to_i).to eq(2)
      expect(ranking_table[2].to_i).to eq(3)
    end
  end

  describe 'verify show commit table', js: true do
    it 'verify show commit message', js: true do
      create(:contributor1)
      commits = [['hashhash1', '2021-01-01', 'commit test message', 1], ['hashhash2', '2022-01-01', 'commit test message2', 1]]
      Commit.import %i[hash committed_on message contributor_id], commits
      commit = Commit.find_by(contributor_id: Contributor.find(1).id)
      visit contributor_commits_path(Contributor.find(commit.contributor_id).name)

      commit_table = page.find('table').all('tr').map { |row| row.all('th, td').map { |cell| cell.text.strip } }
      commit_table.shift
      commit_table = commit_table.transpose[2]

      expect(commit_table[0]).to eq('commit test message')
      expect(commit_table[1]).to eq('commit test message2')
    end
  end

  describe 'verify ', js: true do
    before do
      create(:contributor1)
    end

    it '', js: true do
      visit '/'
      find('input[type="text"]').set('rosh-1228')
      click_button '検索'

      search_result_table = page.find('table').all('tr').map { |row| row.all('th, td').map { |cell| cell.text.strip } }
      search_result_table.shift

      expect(search_result_table.flatten[0]).to eq('rosh-1228')
    end
  end
end
