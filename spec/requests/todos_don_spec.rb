require 'rails_helper'

RSpec.describe "/todos", type: :request do
  let(:valid_attributes) {
    {title: 'Grocery shopping', is_completed: false}
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  let(:valid_headers) {
    {title: 'Grocery shopping', is_completed: false}
  }

  describe "GET /index" do
    it "renders a successful response" do
      Todo.create! valid_attributes
      get api_v1_todos_path, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      todo = Todo.create! valid_attributes
      get api_v1_todo_url(todo), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Todo" do
        expect {
          post api_v1_todos_path,
               params: { todo: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Todo, :count).by(1)
      end

      it "renders a JSON response with the new todo" do
        post api_v1_todos_path,
             params: { todo: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Todo" do
        expect {
          post api_v1_todos_path,
               params: { todo: invalid_attributes }, as: :json
        }.to change(Todo, :count).by(0)
      end

      it "renders a JSON response with errors for the new todo" do
        post api_v1_todos_path,
             params: { todo: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested todo" do
        todo = Todo.create! valid_attributes
        patch api_v1_todo_url(todo),
              params: { todo: new_attributes }, headers: valid_headers, as: :json
        todo.reload
        skip("Add assertions for updated state")
      end

      it "renders a JSON response with the todo" do
        todo = Todo.create! valid_attributes
        patch api_v1_todo_url(todo),
              params: { todo: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the todo" do
        todo = Todo.create! valid_attributes
        patch api_v1_todo_url(todo),
              params: { todo: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested todo" do
      todo = Todo.create! valid_attributes
      expect {
        delete api_v1_todo_url(todo), headers: valid_headers, as: :json
      }.to change(Todo, :count).by(-1)
    end
  end
end
