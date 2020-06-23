# Frontmatter

Frontmatter provides a Rails template handler for views ending in .yaml or .yml
which contain "frontmatter" that is valid YAML contained between two sets of
`---`, such as:

    ---
    author: Caleb Hearth
    website: https://calebhearth.com
    likes:
    - Dogs
    - Frontmatter
    - Rails
    dislikes:
    - Beets
    ---

This frontmatter is parsed and made available as getter methods in a model you
define per "collection" of views. This collection might be "posts" or "talks"
and conceptually it can be considered similarly to an ActiveRecord::Base
subclass, but with the view file as the data source rather than a database.

## Usage

A simple use case would be to import blog posts into Rails from a Jekyll site.
The code to do that might look like the below. Note that the semantics are very
familiar to anyone who's used Rails applications for similar purposes.

### app/models/post.rb

```ruby
class Post < ActionPost::Base
end
```

`ActionPost::Base` provides class-level "all" and "find(slug)" methods which
list all pages and finds the first page matching the slug. It also extracts all
frontmatter and provides it as getter methods such as `post.title`.

### app/controllers/posts_controller.rb

A controller is required, but there is no need to define the default actions.
Default index and show actions are provided that list all posts (all files in
app/views/posts with a .yaml or .yml extension) and finds posts based on their
"slug" which is the filename without any extensions.

```ruby
class PostsController < Frontmatter::BaseController
end
```

The ActionPost::Base subclass is inferred to be the singular of the  Controller's
class name without "Controller", so `PostsController` would render `Post`
objects and look for views in `app/views/posts`. The class-level `renders_page`
method overrides this:

```
class PostsController < Frontmatter::BaseController
  renders_page :blog_post # BlogPost objects / app/views/blog_posts views.
end
```

### config/routes.rb

```ruby
resources :posts, only: %i(index show)
```

### app/views/posts/my-first-post.md.yaml

This original Jekyll file would be called `_posts/2020-05-30-my-first-post.md`
and would not have a date field in the frontmatter. That would need to be
migrated manually or scripted. Date extraction from filename is not a feature of
Frontmatter.

```markdown

---
title: My First Post
date: 2020-05-30
---

Look at all the things I'm not doing!
```

### app/views/posts/show.html.erb

```erb
<h1><%= @page.title %></h1>
<aside><%= time_tag @post.date %></aside>
<%= page_content @page %>
```

### app/views/posts/index.html.erb

```erb
<h1>My Posts</h1>
<ul><% @posts.each do |post| %>
  <li><%= link_to @post.title, post_path(@post) %></li>
<% end %></ul>
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'frontmatter'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install frontmatter
```
