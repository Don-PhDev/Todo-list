require 'rails_helper'

RSpec.describe Api::V1::TodosController do
  let(:json_format) do
    {
      except: %i[
        created_at
        updated_at
      ]
    }
  end
  let(:title) { 'Grocery shopping' }
  let(:is_completed) { false }
  let(:params) do
    {
      todo: {
        title: title,
        is_completed: is_completed,
      }
    }
  end

  describe 'GET /api/v1/todos' do
    let!(:todos) { FactoryBot.create_list(:todo, 3) }
    let(:expected_body) { todos.as_json(json_format) }

    subject { get '/api/v1/todos' }

    it 'returns a list of todos' do
      subject
      expect(response.parsed_body).to eq(expected_body)
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /api/v1/todos/:id' do
    let!(:todo) { create(:todo) }
    let(:expected_body) { todo.as_json(json_format) }

    subject { get "/api/v1/todos/#{todo.id}" }

    it 'returns an todo' do
      subject
      expect(response.parsed_body).to eq(expected_body)
      expect(response.status).to eq(200)
    end
  end

  describe "POST /api/v1/todos" do
    let(:todo) { create :todo }

    subject { post '/api/v1/todos', params: params }

    describe 'validations' do
      before do
        subject
      end

      context 'with invalid input' do
        let(:title) { nil }

        it 'returns failed status' do
          expect(response.parsed_body).to eq('status' => 'failed')
          expect(response.status).to eq(422)
        end
      end

      context 'with valid input' do
        let(:title) { "Grocery shopping" }

        it 'returns success status' do
          expect(response.parsed_body).to eq('status' => 'success')
          expect(response.status).to eq(200)
        end
      end
    end

    it 'creates one todo' do
      expect { subject }.to change { Todo.count }.by(1)
    end
  end

  describe "PATCH /api/v1/todos/:id" do
    let(:title) { "Mop the floor" }
    let!(:todo) { create :todo, title: title }

    subject { patch "/api/v1/todos/#{todo.id}", params: params }

    context 'with invalid input' do
      let(:title) { nil }

      it 'returns failed status' do
        subject
        expect(response.parsed_body).to eq('status' => 'failed')
        expect(response.status).to eq(422)
      end
    end

    context 'with valid input' do
      let(:title) { "Water the plants" }

      it 'returns success status' do
        subject
        expect(response.parsed_body).to eq('status' => 'success')
        expect(response.status).to eq(200)
      end

      it 'successfully updates' do
        expect { subject }.to change { Todo.where(title: title).count }.by(1)
      end
    end
  end
end
