# FootballFacts

<h2>Version</h2>
<p>1.0</p>

<h2>Build and Runtime Requirements</h2>
  <p>Xcode 11.0 or later</p>
  </p>iOS 13.0 or later</p>
</p>Swift 5.0</p>

<h2>About Football Facts</h2>
<p>Football Facts is an app especially designed for avid football fans who want to follow the leagues around the world and stay updated about their favorite teams. This app gives an insight about the leagues, the teams playing, their performance along with their standings for the current year. Since this is a lite version of the app functionaltiy has been limited.</p>

<h2>Application Architecture</h2>
  
 <p>The iOS version follows the Model-View-Controller (MVC) design pattern and uses modern app development practices including Storyboards and Auto Layout. The app lists the current standings for a particular league in a table view implemented in the StandingsViewController class.</p>
 
 <p>Leagues can be changed using  a picker view embedded in a slider view. The top 5 leagues of the world are currently listed in the league picker view.
  
 <p> The DetailTeamTableViewController consisiting of static cells represent the selected team's performance of the current season. 
  
  <p> Offline support has been added in the app using CoreDataModel which consists of two entities, <i>Standings</i> and <i>Competitions</i>. Competitions store related information regading the choice of league whereas Standings represents the standings of the team in each league.</p>
  
<h2>Unit Tests</h2>  
<p> Unit tests have been written for retreiving data for both data model entities - Competitions and Standings and two external json files representing the data has been stored in the project to serve as a sample for testing the data.
