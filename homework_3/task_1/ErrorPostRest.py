from robot.libraries.BuiltIn import BuiltIn


class Session:
    builtin_lib: BuiltIn = BuiltIn()

    def get_requests_lib(self):
        return self.builtin_lib.get_library_instance("Req")

    def take_an_error_postrest_request(self, table, params):
        response = self.get_requests_lib().get_on_session(alias='alias', url=table, params=params)
        response_number = self.builtin_lib.convert_to_string(response)
        return response_number[11:14]
