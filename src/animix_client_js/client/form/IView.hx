package animix_client_js.client.form;

import js.html.Element;

interface IView extends IRenderable {
    public function getId() :Int;
    public function getDomElement() :Element;
}