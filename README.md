# Indoor Localization

## Overview

The **Indoor Localization** is a Flutter application
designed to track assets within a facility. The application
was developed in the Program analysis and development
coursse as a Work Based Learning project.
The application integrates with the backend server, but for a simpler demonstration, the actual web services have been replaced with virtual ones that returns mock data.

## Features
* Asset tracking within the facility in real time using MQTT
* Interactive facility map (zooming, panning)
* Overview of available assets
* Overview of asset movement reports
* Model-View-ViewModel architecture
* Modular design (different ways to display resources)

## Technology
* Flutter
* Supported platforms: Android, Windows (only for developing)

## Screens

### Login page

<img height="700" alt="Home" src="images/login.jpg">

### Home page

<img height="700" alt="Home" src="images/home.jpg">

### Assets overview

<img height="700" alt="Home" src="images/assets.jpg">

### Asset dashboard - position tracking

#### Display asset positions in real time on interactive map

<img alt="Home" src="images/live_asset_position.gif">

#### Generate live asset heatmap 

<img alt="Home" src="images/live_heatmap.gif">

#### Display asset positions in real time as a table

<img height="700" alt="Home" src="images/dashboard_table.jpg">

#### Asset reports

#### Generate report for specific asset and time period

<img height="700" alt="Home" src="images/asset_reports.jpg">

#### Asset heatmap report

<img height="700" alt="Home" src="images/heatmap.jpg">

#### Asset tailmap report

<img alt="Home" src="images/tailmap.gif">

#### Asset zone retention report

<img height="700" alt="Home" src="images/zone_retention.jpg">
