
#' 处理逻辑
#'
#' @param input 输入
#' @param output 输出
#' @param app_id
#' @param run_env
#' @param session 会话
#'
#' @return 返回值
#' @export
#'
#' @examples
#' DeliveryLocationSelectServer()
DeliveryLocationSelectServer <- function(input,output,session,app_id, run_env = "PRD"){

  # 获取所有字段名
  DeliveryLocation_all_columns <- c(
    'Delivery Location',
    'Sales OrderID',
    'Sales OrderDate',
    'PN',
    'Product Name',
    'Sales OrderQty',
    'Delivery Date',
    'Delivery Qty'
  )

  #设置默认值
  DeliveryLocation_default_columns <- c(
    'Delivery Location',
    'Sales OrderID',
    'Sales OrderDate',
    'PN',
    'Product Name',
    'Sales OrderQty',
    'Delivery Date',
    'Delivery Qty'
  )
  DeliveryLocation_reset_columns <- c(
    'Delivery Location',
    'Sales OrderID',
    'PN',
    'Product Name'

  )

  # 全选按钮
  observeEvent(input$btn_DeliveryLocation_select_all, {
    updatePickerInput(
      session = session,
      inputId = "DeliveryLocation_column_selector",
      selected = DeliveryLocation_all_columns
    )
  })

  # 取消全选按钮
  observeEvent(input$btn_DeliveryLocation_deselect_all, {
    updatePickerInput(
      session = session,
      inputId = "DeliveryLocation_column_selector",
      selected = DeliveryLocation_reset_columns
    )
  })
  # 默认值按钮
  observeEvent(input$btn_DeliveryLocation_defaultValue, {
    updatePickerInput(
      session = session,
      inputId = "DeliveryLocation_column_selector",
      selected = DeliveryLocation_default_columns
    )
  })
  #获取参数
  text_DeliveryLocation=tsui::var_text('text_DeliveryLocation')
  #查询按钮
  # 显示选择信息
  output$DeliveryLocation_selection_info <- renderPrint({
    selected <- input$DeliveryLocation_column_selector
    cat("Column Count: ", length(selected), "\n")
    cat("Column List: ", paste(selected, collapse = ", "), "\n")
    FDeliveryLocation=text_DeliveryLocation()
    cat("Delivery Location:",FDeliveryLocation)
  })



  #查询按钮

  shiny::observeEvent(input$btn_DeliveryLocation_view,{

    FDeliveryLocation=text_DeliveryLocation()


    if(FDeliveryLocation==''){

      tsui::pop_notice("Please Enter Delivery Location")


    }else{
      erp_token = rdbepkg::dbConfig(FAppId = app_id, FType = "ERP", FRunEnv = run_env)
      data = mdlVMSalesDeliveryPkg::DeliveryLocation_select(erp_token = erp_token,FDeliveryLocation = FDeliveryLocation)
      data_selected = data[ ,input$DeliveryLocation_column_selector,drop=FALSE]
      # 增加对英文的支持datatable.
      tsui::run_dataTable2(id ='DeliveryLocation_resultView' ,data =data_selected,lang = 'en' )

      filename=paste('DeliveryLocation-',Sys.Date(),'.xlsx')

      tsui::run_download_xlsx(id = 'dl_DeliveryLocation',data = data_selected,filename = filename)


    }


  })



}


#' 处理逻辑
#'
#' @param input 输入
#' @param output 输出
#' @param app_id
#' @param run_env
#' @param session 会话
#'
#' @return 返回值
#' @export
#'
#' @examples
#' DeliveryLocationServer()
DeliveryLocationServer <- function(input,output,session, app_id, run_env = "PRD"){
  DeliveryLocationSelectServer(input = input,output = output,session = session,app_id=app_id, run_env = run_env)


}
