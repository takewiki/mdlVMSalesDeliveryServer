
#' 处理逻辑
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param dms_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples
#' DeliveryLocationSelectServer()
DeliveryLocationSelectServer <- function(input,output,session,dms_token) {
  #获取参数
  text_DeliveryLocation=tsui::var_text('text_DeliveryLocation')


  #查询按钮

  shiny::observeEvent(input$btn_DeliveryLocation_view,{

    FDeliveryLocation=text_DeliveryLocation()


    if(FDeliveryLocation==''){

      tsui::pop_notice("Please Enter Delivery Location")


    }else{
      data = mdlVmDeliveryLocationr::DeliveryLocation_selectByDate(dms_token = dms_token,FCalculateYear = FCalculateYear,FLatestVersion =FLatestVersion ,FVersion = FVersion,FCalculationPeriod = FCalculationPeriod)

      tsui::run_dataTable2(id ='DeliveryLocation_resultView' ,data =data )

      tsui::run_download_xlsx(id = 'dl_DeliveryLocation',data = data,filename = 'DeliveryLocation.xlsx')


    }


  })



}


#' 处理逻辑
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param dms_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples
#' DeliveryLocationServer()
DeliveryLocationServer <- function(input,output,session,dms_token) {
  DeliveryLocationSelectServer(input = input,output = output,session = session,dms_token = dms_token)


}
