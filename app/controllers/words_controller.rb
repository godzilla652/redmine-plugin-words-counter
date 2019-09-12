class WordsController < ApplicationController

  def index
    @projects = Project.all
    @roles = Role.all
    @trackers = Tracker.all
    @groups = Group.all

    words = Word.all
    @rule_projects = []
    @rule_roles = []
    @rule_trackers = []
    @rule_groups = []

    words.each do |word|
      @rule_projects << word.object_id if word.name == 'project'
      @rule_roles << word.object_id if word.name == 'role'
      @rule_trackers << word.object_id if word.name == 'tracker'
      @rule_groups << word.object_id if word.name == 'group'
    end

    @last_message = WMessage.first.body

  end

  def set_rules
    
    Word.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('words')

    params[:projects].each do |key, value|
      Word.create name: 'project', object_id: key.to_i
    end unless params[:projects].nil?

    params[:roles].each do |key, value|
      Word.create name: 'role', object_id: key.to_i
    end unless params[:roles].nil?

    params[:groups].each do |key  , value|
      Word.create name: 'group', object_id: key.to_i
    end unless params[:groups].nil?

    params[:trackers].each do |key, value|
      Word.create name: 'tracker', object_id: key.to_i
    end unless params[:trackers].nil?

    flash[:notice] = "New rules successfully created"
    redirect_to :back

  end

  def set_message
    WMessage.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('w_messages')

    WMessage.create body: params[:message]

    flash[:notice] = "Message successfully created"
    redirect_to :back
  end
  

end
