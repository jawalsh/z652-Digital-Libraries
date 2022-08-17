# Week 3: CollectionBuilder Introduction


## Summary
For this week, you will complete a tutorial to set up a sample [CollectionBuilder](https://collectionbuilder.github.io) collection in GitHub. 

Olivia Wikle and Devin Becker will join the class to discuss the CollectionBuilder project and answer questions about CollectionBuilder. 

[Olivia Wikle](https://cdil.lib.uidaho.edu/people/#profile-olivia-wikle) is the Digital Initiatives Librarian and Co-Director of the Center for Digital Inquiry and Learning (CDIL) at the University of Idaho. She is also Communications Director for CollectionBuilder and a former ILS student at Indiana University.  

[Devin Becker](https://cdil.lib.uidaho.edu/people/#profile-devin-becker) is the Head of Data and Digital Services and Co-Director of the Center for Digital Inquiry and Learning (CDIL) at the University of Idaho. He is the Project Director for CollectionBuilder and also a former ILS student at Indiana University.


## Weekly Learning Objectives


## Before class: Readings, Resources, and Tasks
### Readings
 - Gil, Alex. "The User, the Learner and the Machines We Make." *Minimal Computing*, May 21, 2015. <https://go-dh.github.io/mincomp/thoughts/2015/05/21/user-vs-learner/>.
- Wikle, Olivia, Evan Williamson, and Devin Becker. “What is Static Web and What’s it Doing in the Digital Humanities Classroom?” *dh+lib*, June 22, 2020. <https://acrl.ala.org/dh/2020/06/22/what-is-static-web-and-whats-it-doing-in-the-digital-humanities-classroom>.
- [Lib-Static](https://lib-static.github.io)
	- [“Why Lib-Static?”](https://lib-static.github.io/about/)
	- On the [Concepts](https://lib-static.github.io/concepts/) page read the following:
		- [Command Line](https://lib-static.github.io/concepts/cli/);
		- [Static Site Generators](https://lib-static.github.io/concepts/static-site-generators/);
		- [Plain Text](https://lib-static.github.io/concepts/plaintext/).
	- Explore other [Concepts](https://lib-static.github.io/concepts/) and [Models](https://lib-static.github.io/models/) as you are able.
		
### Tasks

#### Build a digital collection with [CollectionBuilder](https://collectionbuilder.github.io)

You will need a GitHub account and Google Drive account to participate in this exercise. Both account types are free. Go to <https://github.com/> and <https://www.google.com/drive/> to set them up if you don’t already have them.
 
We recommend using following demo data as you’re building your collection for the first time:
- Psychiana Digital Collection Metadata (you’ll need to log in to Google Drive to copy this spreadsheet): <https://docs.google.com/spreadsheets/d/1x48Te3duPAxh53foEihQVKTfCKUjaCCbH7TrMMd_yU4/copy>
- Psychiana Digital Collection Media Files: <https://www.lib.uidaho.edu/collectionbuilder/demo-objects.zip>
 
This exercise will use the CollectionBuilder-GH repository (<https://github.com/CollectionBuilder/collectionbuilder-gh>) which allows you to build a free digital collection website using GitHub Pages. You can explore a demo collection here: <https://collectionbuilder.github.io/collectionbuilder-gh/>, and the CollectionBuilder website here: <https://collectionbuilder.github.io/>.  
 
Homework—Set up an instance of CollectionBuilder-GH following these steps (links to documentation are included):
 
1. Log in to GitHub (<https://github.com/>)
2. Copy the CollectionBuilder-GH template (follow the “Generate from Template” documentation and choose the “GH (GitHub pages)” repository option: <https://collectionbuilder.github.io/cb-docs/docs/repository/create/#generate-from-template>)
3. Turn on GitHub Pages (<https://collectionbuilder.github.io/cb-docs/docs/deploy/gh-pages/>)
4. Objects:
	- Click this link to download a zipped folder of demo digital collection media files: https://www.lib.uidaho.edu/collectionbuilder/demo-objects.zip
	- Once downloaded, right click the zipped folder and select “extract all” or “unzip” to unzip the folder.
	- Add all of the files in the folder you just unzipped to the “objects” folder in your CollectionBuilder GitHub repository (https://collectionbuilder.github.io/cb-docs/docs/objects/gh-objects/)
5. Metadata:
	- Log in to Google Drive, then click on the following link to copy a demo metadata spreadsheet for your collection: <https://docs.google.com/spreadsheets/d/1x48Te3duPAxh53foEihQVKTfCKUjaCCbH7TrMMd_yU4/copy>
	- Follow the documentation to download your metadata spreadsheet as a CSV from Google Sheets, then upload it to the “_data” folder in your repository (<https://collectionbuilder.github.io/cb-docs/docs/metadata/uploading/>)
6. Configure site-wide settings using the `_config.yml` file (<https://collectionbuilder.github.io/cb-docs/docs/config/>)
7. At this point your site should be functional! GitHub Pages can take a minute or two to update, so after you’ve edited your `_config.yml` file, wait a bit, then refresh your GitHub Pages site to see your objects appear.
8. Configure a few display options using the _data/theme.yml file (<https://collectionbuilder.github.io/cb-docs/docs/theme/>). Commit any changes you make, then refresh your site to see the results.
9. Further configure and customize pages using a few of the _data/config- csv files (<https://collectionbuilder.github.io/cb-docs/docs/customization/>). Commit any changes you make, then refresh your site to see the results.

**Note:** you can also follow along with these steps using our video tutorial (<https://collectionbuilder.github.io/workshop/gh/>), but please note that these videos are a little out of date so you’ll want to refer to the documentation linked above as well.
 
If you’d like to prepare your own objects and metadata for your digital collection instead of using the demo data, follow these guidelines:

1. Prep objects for your digital collection
	- Number: 10-30 objects
	- Formats: jpg, pdf, mp3, YouTube, Vimeo
	- Size: GitHub repositories are limited to 1GB, so make sure the total size of your objects folder is less than around 500MB. Secondly, since CollectionBuilder-GH does not use thumbnails, keep your objects to a reasonable size for access on the web. The objects are usually not your full resolution versions. For example, jpg images about 1000px wide and pdfs less than 1 MB will work well.
	- Location: for easy uploading to GitHub, gather your prepared objects in one folder on your computer.
2. Prep metadata
	- Log in to Google Drive. Then, using Google Sheets, make a copy of the CollectionBuilder-GH metadata template (<https://docs.google.com/spreadsheets/d/1Uv9ytll0hysMOH1j-VL1lZx6PWvc1zf3L35sK_4IuzI/copy>) (Click the blue,  "Make a Copy" button on the page that opens when you click the link).
	- Follow our metadata guidelines (<https://collectionbuilder.github.io/cb-docs/docs/metadata/gh_metadata/>) to begin filling in the template. Any custom field can be added based on the needs of your project, but column names should be lowercase with no spaces or odd characters.