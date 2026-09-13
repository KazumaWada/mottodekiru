# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# NOTE: 開発環境だけ適応される。
if Rails.env.development?
  # ここを最初に登録する時のクエリを()内に入れる必要がある。以下の行はUPSERT
  user = User.find_or_create_by!(email: "test@example.com") do |u|
  # ここでuserが見つからなかったら、実際に新規作成のデータを入れていく必要がある。
    u.name = "kazuma"
    u.password = "wmkm0511"
    u.password_confirmation = "wmkm0511"
    u.validated = true
  end

  # postがあれば、ここでuserを紐付けたpostをここで書くことができる。
  user.microposts.find_or_create_by!(content: "サンプル投稿です", reference_link: "https://www.youtube.com/watch?v=WMcyhKlFTao", tags: "funny")
  user.microposts.find_or_create_by!(content: "サンプル投稿です", reference_link: "https://www.youtube.com/watch?v=WMcyhKlFTao", tags: "cat")
  user.microposts.find_or_create_by!(content: "サンプル投稿です", reference_link: "https://www.youtube.com/watch?v=WMcyhKlFTao", tags: "life")
end