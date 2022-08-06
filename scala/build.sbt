version := "0.1.0-SNAPSHOT"

ThisBuild / scalaVersion := "2.13.8"

libraryDependencies += "org.scalatest" %% "scalatest" % "3.2.12" % Test

lazy val root = (project in file("."))
  .settings(
    name := "learning-dutch"
  )
