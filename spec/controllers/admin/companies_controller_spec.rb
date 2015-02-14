require 'rails_helper'

RSpec.describe Admin::CompaniesController, :type => :controller do 

	before(:each) do
		allow(controller).to receive(:require_login).and_return(true)
		allow(controller).to receive(:require_admin).and_return(true) 
	end

	describe 'GET index' do 
		before(:each) do 
			@companies = Array.new(3) { build(:company) }
			allow(Company).to receive(:all).and_return(@companies)
		end

		it 'instantiates a new company' do 
			get :index
			expect(assigns(:company)).to be_a_new(Company)
		end

		it 'gets all companies' do 
			get :index
			expect(assigns(:companies).size).to eq(3)
		end
	end

	describe 'POST create' do 
		describe 'with valid company attributes' do 
			before(:each) do
				@company = build(:company)
				allow(Company).to receive(:new).and_return(@company)
				allow(@company).to receive(:save).and_return(true)
				allow(@company).to receive(:id).and_return(1)
			end

			it 'assigns a company variable' do 
				post :create, company: attributes_for(:company)
				expect(assigns(:company)).to be(@company)
			end

			it 'redirects' do 
				post :create, company: attributes_for(:company)
				expect(response).to be_redirect
			end
		end

		describe 'with invalid company attributes' do 
			before(:each) do 
				@company = build(:blank_company)
				allow(@company).to receive(:save).and_return(false)
				allow(Company).to receive(:new).and_return(@company)
			end

			it 'assigns an error variable' do 
				post :create, company: attributes_for(:blank_company)
				expect(assigns(:error)).not_to be_nil
			end

			it 're-renders the form' do 
				post :create, company: attributes_for(:blank_company)
				expect(response).to render_template('admin/companies/new')
			end
		end
	end

	describe 'GET new' do 
		it 'instantiates a new company' do 
			get :new, id: 1
			expect(assigns(:company)).to be_a_new(Company)
		end
	end

	describe 'GET show' do 
		before(:each) do 
			allow(Company).to receive(:includes).and_return(Company)
			allow(Company).to receive(:find).and_return(build(:company, id: 1))
		end

		it 'assigns the company' do 
			get :show, id: 1
			expect(assigns(:company)).to be_a(Company)
			expect(assigns(:company).id).to eq(1)
		end

		it 'instantiates a new office' do
			get :show, id: 1
			expect(assigns(:office)).to be_a_new(Office)
		end
	end

	describe 'POST lock' do 
		describe 'valid company' do 
			before(:each) do 
				@company = build(:company, id: 1, locked: false)
				allow(Company).to receive(:find_by).and_return(@company)
			end

			it 'toggles locked attribute' do 
				post :lock, id: 1
				expect(@company).to be_locked
			end

			it 'toggles locked attribute' do 
				post :lock, id: 1
				expect(@company).to be_locked
				post :lock, id: 1
				expect(@company).not_to be_locked
			end

			it 'renders status 200' do 
				post :lock, id: 1
				expect(response).to have_http_status(200)
			end
		end

		describe 'invalid company' do 
			before(:each) do 
				allow(Company).to receive(:find_by).and_return(nil)
			end

			it 'renders status 500' do 
				post :lock, id: 1
				expect(response).to have_http_status(500)
			end
		end
	end

end