<div id="saveDiv">
    <section class="content no-padding-bottom">
        <div class="row">
            <form class="form-horizontal form-striped">
            <#if (bppTagGroup.id)??>
                <div class="form-group">
                    <label for="id" class="col-sm-2 control-label">标签Id</label>
                    <div class="col-sm-3">
                        <input class="form-control input-sm" readonly="readonly" id="id"
                               name="bppTagGroup.id" value="${bppTagGroup.id}">
                    </div>
                </div>
            </#if>
                <div class="form-group">
                    <label for="groupname" class="col-md-2 control-label text-red">*&nbsp;标签组名称</label>
                    <div class="col-md-3">
                        <input type="text" class="form-control input-sm" placeholder="请输入名称" id="groupname"
                               name="bppTagGroup.groupname" value="${(bppTagGroup.groupname)!}">
                    </div>
                </div>
                <div class="form-group">
                    <label for="rank" class="col-md-2 control-label">权重</label>
                    <div class="col-md-3">
                        <input type="text" class="form-control input-sm" id="rank" name="bppTagGroup.rank"
                               value="${(bppTagGroup.rank)!0}">
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-md-5">
                        <button type="submit" class="btn btn-success">&nbsp;&nbsp;提交&nbsp;&nbsp;</button>
                    </div>
                </div>
            </form>
        </div>
    </section>
</div>