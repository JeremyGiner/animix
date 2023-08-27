package animix_client_js.client.form;

interface IForm<C> {
    public function validate() :Bool;
    public function getValue() :C;
}