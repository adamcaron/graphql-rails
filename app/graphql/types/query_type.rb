module Types
  class QueryType < Types::BaseObject
    # queries are just represented as fields
    # `all_links` is automatically camelcased to `allLinks`
    field :all_links, [LinkType], null: false

    # this method is invoked, when `all_link` fields is being resolved
    def all_links
      Link.all
    end
  end
end

# Example Query...
# {
#   allLinks {
#     id
#     url
#     description
#   }
# }

# Produces...
# {
#   "data": {
#     "allLinks": [
#       {
#         "id": "1",
#         "url": "http://graphql.org/",
#         "description": "The Best Query Language"
#       },
#       {
#         "id": "2",
#         "url": "http://dev.apollodata.com/",
#         "description": "Awesome GraphQL Client"
#       }
#     ]
#   }
# }

# Given... (in the database...)
# 2.6.5 :001 > Link.create url: 'http://graphql.org/', description: 'The Best Query Language'
# => #<Link id: 1, url: "http://graphql.org/", description: "The Best Query Language", created_at: "2020-06-16 01:46:51", updated_at: "2020-06-16 01:46:51">
# 2.6.5 :002 > Link.create url: 'http://dev.apollodata.com/', description: 'Awesome GraphQL Client'
# => #<Link id: 2, url: "http://dev.apollodata.com/", description: "Awesome GraphQL Client", created_at: "2020-06-16 01:47:48", updated_at: "2020-06-16 01:47:48">


# And now...
# after adding
# votes to linkType
# and has_many votes to Link
# ... this
# query {
#   allLinks {
#     votes {
#       id
#     }
#   }
# }
# Returns this...
# {
#   "data": {
#     "allLinks": [
#       {
#         "votes": []
#       },
#       {
#         "votes": []
#       },
#       {
#         "votes": []
#       },
#       {
#         "votes": [
#           {
#             "id": "1"
#           }
#         ]
#       },
#       {
#         "votes": []
#       },
#       {
#         "votes": []
#       }
#     ]
#   }
# }