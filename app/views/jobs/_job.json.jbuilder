json.extract! job, :id, :title, :link, :city, :post_time, :created_at, :updated_at
json.url job_url(job, format: :json)
