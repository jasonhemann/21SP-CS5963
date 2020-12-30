# 21SP-CS5963

Repository for Hemann's Spring Intersession edition of CS5963

# Dependencies


# Building 

To build this site locally, copy or clone this repository, and then
execute `jekyll build` from within the top directory. You may prefer
using `bundle`, that is `bundle exec jekyll build`. To run it locally,
use `jekyll serve` rather than `jekyll build`, as appropriate.

# New Posts

To create a new homework assignment, lab assignment, lecture, to add a
new person, or enrichment resource, enter the corresponding
sub-directory, and from there, create a new entry within `_posts`. The
existing entries should serve as models.

# Deployment 

To fully for a new semester in a new shell, do the following:

## Site

   1. Add your and the TA's office hours to the office hours page
   1. Add the lecture time date and location to the index page
   1. Change the handins link if you intend to use it. 
   1. In _data/navigation.yml, update the URL for the repo
   1. Change everywhere the course title is hardcoded. Global search and replace
   1. Change everywhere the year is hard-coded. Global search-and-replace

## Canvas 

Using a copy of my basic canvas site shell, 

  1. add a copy of the `Redirect` app targeting the home page
  1. add a copy of the `Redirect` app targeting the syllabus
  

## Site again

Change the Zoom link on the `index.md` page to the internal NEU canvas
link.

	
