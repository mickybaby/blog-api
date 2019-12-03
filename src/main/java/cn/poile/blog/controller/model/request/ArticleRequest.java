package cn.poile.blog.controller.model.request;

import cn.poile.blog.common.validator.annotation.ListSize;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.List;

/**
 * @author: yaohw
 * @create: 2019-11-15 15:08
 **/
@ApiModel(value = "文章请求json",description = "文章请求体")
@AllArgsConstructor
@NoArgsConstructor
@Data
public class ArticleRequest {

    @ApiModelProperty(value = "文章id，编辑时不可空")
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @ApiModelProperty(value = "作者，转载时不能为空")
    private String author;

    @NotNull(message = "文章分类id不能为空")
    @ApiModelProperty(value = "文章分类id")
    private Integer categoryId;

    @NotBlank(message = "文章标题不能为空")
    @ApiModelProperty(value = "文章标题")
    private String title;

    @NotBlank(message = "文章摘要不能为空")
    @ApiModelProperty(value = "文章摘要")
    private String summary;

    @NotBlank(message = "文章内容不能为空")
    @ApiModelProperty(value = "文章内容")
    private String content;

    @NotBlank(message = "文章封面不能为空")
    @ApiModelProperty(value = "文章封面")
    private String cover;

    @ListSize(max = 5,message = "一篇文章最多只允许添加5个标签")
    @ApiModelProperty(value = "文章标签id列表")
    private List<Integer> tagIds;

    @NotNull(message = "是否转载字段不能为空")
    @ApiModelProperty(value = "是否转载,1:是，0:否")
    private Integer reproduce;

}