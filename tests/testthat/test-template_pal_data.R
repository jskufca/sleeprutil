test_that("pal data reads correctly", {

  df1=redcap_template
  df2=template_pal_data(testing=TRUE)


  expect_equal(names(df1), names(df2))
})
