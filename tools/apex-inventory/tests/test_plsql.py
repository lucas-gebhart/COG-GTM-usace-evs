from apex_inventory.plsql import eval_expr, iter_calls, split_top_level


def test_eval_scalars():
    assert eval_expr("null") is None
    assert eval_expr("true") is True
    assert eval_expr("42") == 42
    assert eval_expr("wwv_flow_imp.id(123456789012345678901)") == 123456789012345678901
    assert eval_expr("'it''s'") == "it's"
    assert eval_expr("nvl(wwv_flow_application_install.get_application_name,'Mini')") == "Mini"


def test_eval_join_and_concat():
    expr = "wwv_flow_string.join(wwv_flow_t_varchar2(\n'select ''a'', b',\n'from t'))"
    assert eval_expr(expr) == "select 'a', b\nfrom t"
    assert eval_expr("'.'||wwv_flow_imp.id(600)||'.'") == ".600."
    attrs = eval_expr("wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(\n'k1','v1',\n'k2','v2')).to_clob")
    assert attrs == {"k1": "v1", "k2": "v2"}


def test_eval_unknown_expression_is_raw():
    assert eval_expr("wwv_flow.g_flow_id") == "wwv_flow.g_flow_id"


def test_split_top_level_respects_strings_and_nesting():
    args, end = split_top_level("a=>'x,(y)', b=>f(1,2), c=>3) tail", 0)
    assert args == ["a=>'x,(y)'", " b=>f(1,2)", " c=>3"]
    assert end == len("a=>'x,(y)', b=>f(1,2), c=>3)")


def test_iter_calls_tracks_names_lines_and_args():
    text = (
        "begin\n"
        "wwv_flow_imp_page.create_page(\n p_id=>7\n,p_name=>'home'\n);\n"
        "wwv_flow_imp_page.create_page_plug(\n p_id=>wwv_flow_imp.id(10)\n,p_plug_name=>'A, (B)'\n"
        ",p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(\n'select 1',\n'from dual'))\n);\n"
        "end;\n"
    )
    calls = iter_calls(text, "x.sql")
    assert [c.name for c in calls] == ["create_page", "create_page_plug"]
    assert calls[0].line == 2 and calls[0].args == {"p_id": 7, "p_name": "home"}
    assert calls[1].args["p_plug_name"] == "A, (B)"
    assert calls[1].args["p_plug_source"] == "select 1\nfrom dual"
    assert calls[1].id() == "10"
