class ProjectsController < ApplicationController
  load_and_authorize_resource
  def index
    if params[:by_tag]
      @projects = @projects.tagged_with(params[:by_tag])
      @title = I18n.t('projects.title_by_tag', tag: params[:by_tag])
    else
      @title = I18n.t('projects.works')
    end
    @projects = @projects.order(created_at: :desc).includes(:taggings)
  end

  def show
    @containers = @project.containers.order(:position).includes(:slides)
  end

  def new;  end
  def edit; end

  def create
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def project_params
      params.require(:project).permit(:title,
                                      :desc,
                                      :preview,
                                      :hide,
                                      :authors_mask,
                                      :tag_list,
                                      { authors: [] },
                                      :containers_attributes => [:id,
                                                              :content,
                                                              :types_mask,
                                                              :_destroy,
                                                              [ slides_attributes: [:id, :slide, :_destroy]]]
                                    )
    end
end
