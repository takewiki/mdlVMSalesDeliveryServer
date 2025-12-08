
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
  #获取参数
  text_DeliveryLocation=tsui::var_text('text_DeliveryLocation')


  #查询按钮

  shiny::observeEvent(input$btn_DeliveryLocation_view,{

    FDeliveryLocation=text_DeliveryLocation()


    if(FDeliveryLocation==''){

      tsui::pop_notice("Please Enter Delivery Location")


    }else{
      erp_token = rdbepkg::dbConfig(FAppId = app_id, FType = "ERP", FRunEnv = run_env)
      data = mdlVMSalesDeliveryPkg::DeliveryLocation_select(erp_token = erp_token,FDeliveryLocation = FDeliveryLocation)
      tsui::run_dataTable2(id ='DeliveryLocation_resultView' ,data =data )

      tsui::run_download_xlsx(id = 'dl_DeliveryLocation',data = data,filename = 'DeliveryLocation.xlsx')


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
