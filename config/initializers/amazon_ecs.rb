Amazon::Ecs.options = {
  associate_tag: ENV["AMAZON_ASSOCIATE"],
  AWS_access_key_id: ENV["AMAZON_ACCESS_KEY"],
  AWS_secret_key:    ENV["AMAZON_SECRET_KEY"]
}
