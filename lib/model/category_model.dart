class CategoryModel {
	String mallCategoryId;
	String mallCategoryName;
	List<BxMallSubDto> bxMallSubDto;
	String image;
	
	CategoryModel(this.mallCategoryId, this.mallCategoryName, this.bxMallSubDto,
			this.image);
	
	factory CategoryModel.formJson(dynamic json){
			List _list = json['bxMallSubDto'];
			return CategoryModel(
					json['mallCategoryId'],json['mallCategoryName'], _list.map((val) =>BxMallSubDto.fromJson(val)).toList(),json['image']);
	}
	
}

class CategoryListModel {
/*	String mallSubId;
	String mallCategoryId;
	String mallSubName;
	String comments;*/
List<CategoryModel> data;


CategoryListModel(this.data);

factory CategoryListModel.formJson (List json){
		return CategoryListModel(json.map((val) => CategoryModel.formJson(val)).toList());
	}
	
}


class BxMallSubDto {
	String mallSubId;
	String mallCategoryId;
	String mallSubName;
	var comments;
	
	BxMallSubDto(this.mallSubId, this.mallCategoryId, this.mallSubName,
			this.comments);
	
	factory BxMallSubDto.fromJson(json){
		return BxMallSubDto(json['mallSubId'], json['mallCategoryId'], json['mallSubName'], json['comments']);
	}
	
	
}

