context("Testing loading of environments via json")

test_that("Test object returned from jsonEnv() has correct attributes", {
  json.df <- jsonEnv("json/test_strings.json", 
                                    global = FALSE)
  # check the returned object
  expect_is(json.df, "environment")
  expect_named(json.df)
  expect_length(json.df, 5)
  
  real.names <- c("field1", "house", "color", "stuffed", "team")
  json.names <- names(json.df)
  for ( label.i in 1:5 ) {
    expect_equal(real.names[[label.i]], json.names[[label.i]])
  }
  
  real.values <- c("john wall", "mudge", "purple", "whale", "Detroit Lions")
  for ( key.i in 1:5 ) {
    name.i <- json.names[[key.i]]
    expect_equal(getElement(json.df, name.i), real.values[[key.i]])
  }
})

test_that("jsonEnv() correctly loads variables into global environment", {
  jsonEnv("json/test_global.json", 
          global = TRUE)
  
  ## check for existance
  expect_true(exists("frosh"))
  expect_true(exists("fraternity"))
  expect_true(exists("rooms"))
  expect_true(exists("color"))
  expect_true(exists("house"))
  
  ## check for value
  expect_equal(frosh, "scobell")
  expect_equal(fraternity, "Delta Tau Delta")
  expect_equal(rooms, c("113", "310A", "209", 
                        "C203", "302", "A101"))
  expect_equal(color, "purple")
  expect_equal(house, "mudge")
  
})

