class SectionsController < ApplicationController

  # Find the section ID before any other action
  before_action :find_section, only: [:show, :edit, :update, :destroy, :flashcards, :quiz]
  before_action :authenticate_admin!, only: [:new, :edit]


  def index
    @section = Section.all.order("semester DESC")
  end

  def show
  end

  def new
    @section = current_admin.sections.build
    # @section = Section.new
    # @section.admin_id = current_admin.id
  end

  def create
    @section = current_admin.sections.build(section_params)
    # @section = Section.new(section_params)
    # @section.admin_id = current_admin.id

    if @section.save
      redirect_to root_path
    else
      # Display form to input fields for new Section
      render 'new'
    end
  end

  def edit
    @section = Section.find(params[:id])
  end

  def update
    # If Section is updated successfully
    if @section.update(section_params)
      redirect_to section_path(@section)
    else
    # Display form to edit Section info
      render 'edit'
    end
  end

  def destroy
    @section.destroy
      redirect_to root_path
  end

  # only needs section passed in, handled in before_action
  def flashcards
  end

  # only needs section passed in, handled in before_action
  def quiz
  end



  private

    # Define what fields are required to edit or create a new Section
    def section_params
      params.require(:section).permit(:course, :semester, :year, :professor)
    end

    # Find the section by it's ID
    def find_section
      @section = Section.find(params[:id])
    end
  end
