package animix_client_js.client.form;

interface IViewComposite extends IView {
    public function getClientChild( uid :Int ) :IView;
}