test_that("oxi data reads correctly", {

  df1=redcap_template
  df2=template_oxi_data(testing=TRUE)


  expect_equal(names(df1), names(df2))
})
