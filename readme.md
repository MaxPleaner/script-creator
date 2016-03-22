### Script Creator

#### About

a web app for managing local ruby scripts.

You can write / edit the scripts in the browser.

They can also be execute and the response is shown in the browser.

Furthermore, there is now a CRUD interface for making HTML pages.

The pages are stored in the database and you can view them on the site.

The site has been refactored to be a bit more like a single page app.

#### How to use:

- Clone repo

- `bundle install`

- `rails server`

- go to `localhost:3000`

Note that I haven't made any effort to try and deploy this app.

#### Another thing

Use the following example to script REPLs (interactive script). i.e. commands that hang unless an exit command is given.

```bash
$ (echo "print 'hello world'"; echo "exit") | ./ruby-cli-skeleton | grep hello
```

This does a couple thigns:
  - combines multiple `echo` calls into a single output by wrapping them in parens and separating them using semicolons.
  - issues ruby commands via `echo`, including one for `exit` which is necessary.
  - pipes the `echo` to the cli script, and pipes the script output to `grep`, searching the text. 

