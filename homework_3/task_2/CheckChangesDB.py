from robot.libraries.BuiltIn import BuiltIn
from JsonValidator import JsonValidator


class Table:
    builtin_lib: BuiltIn = BuiltIn()
    JS = JsonValidator()

    def get_requests_lib(self):
        return self.builtin_lib.get_library_instance("Req")

    def post_new_data(self, data):
        self.get_requests_lib().post_on_session(alias='alias', url='/categories?', data=data, json='application/json')

    def get_category_id_and_category_name_customers_from_postrest(self):
        response = self.get_requests_lib().get_on_session(alias='alias', url='/categories?', expected_status='200')
        category = self.JS.get_elements(response.json(), '$..category')
        categoryname = self.JS.get_elements(response.json(), '$..categoryname')
        return category, categoryname

    def get_postgresql_lib(self):
        return self.builtin_lib.get_library_instance("DB")

    def get_category_id_and_category_name_customers_from_db(self):
        sql = """SELECT * from bootcamp.categories"""
        result = self.get_postgresql_lib().execute_sql_string_mapped(sql)
        category_db = []
        categoryname_db = []
        for k in result:
            category_db.append(k['category'])
            categoryname_db.append(k['categoryname'])
        return categoryname_db, category_db

    def get_col_lib(self):
        return self.builtin_lib.get_library_instance("Col")

    def compare_results(self, category, categoryname, category_db, categoryname_db):
        self.get_col_lib().lists_should_be_equal(category, category_db)
        self.get_col_lib().lists_should_be_equal(categoryname, categoryname_db)
