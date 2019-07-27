package routers

import (
	"github.com/fusionshen/go-learning/hellobee/controllers"
	"github.com/astaxie/beego"
)

func init() {
    beego.Router("/", &controllers.MainController{})
}
