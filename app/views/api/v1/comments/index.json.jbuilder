json.comments @comments do |c|
    json.partial! 'api/v1/comments/comment', locals: {comment: c}
end